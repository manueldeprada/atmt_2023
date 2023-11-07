import torch
import sentencepiece as spm
from .dictionary import Dictionary


class BPEDictionary(Dictionary):
    def __init__(self, pad='<pad>', eos='</s>', unk='<unk>'):
        self.pad_word, self.eos_word, self.unk_word = pad, eos, unk
        self.pad_idx = 0
        self.eos_idx = 1
        self.unk_idx = 2
        self.sp_model = None
        self.alpha = 0.0

    def __len__(self):
        return self.sp_model.get_piece_size()

    def __getitem__(self, idx):
        return self.sp_model.IdToPiece(int(idx))

    def index(self, word):
        return self.sp_model.PieceToId(word)

    def add_word(self, word, n=1):
        raise NotImplementedError

    def binarize(self, string, tokenizer, append_eos=True, add_if_not_exist=False, consumer=None):
        sampling = True if self.alpha > 0.0 else False
        encoding = self.sp_model.encode_as_ids(string, enable_sampling=sampling, alpha=self.alpha, add_eos=True)
        return torch.LongTensor(encoding)
        


    def string(self, tensor, bpe_symbol=None):
        if torch.is_tensor(tensor) and tensor.dim() == 2:
            return '\n'.join(self.string(t) for t in tensor)
        if type(tensor) != list:
            tensor = tensor.tolist()
        sentence = self.sp_model.DecodeIds(tensor)
        return sentence

    def finalize(self, threshold=-1, num_words=-1):
        raise NotImplementedError

    @classmethod
    def load(cls, filename):
        """Loads the dictionary from a text file"""
        dictionary = cls()
        dictionary.sp_model = spm.SentencePieceProcessor(model_file=filename)
        return dictionary

    def save(self, file):
        raise NotImplementedError
